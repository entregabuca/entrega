class EpaycoController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:result, :confirmation]

  def result
  	url = "https://secure.epayco.co/validation/v1/reference/#{params[:ref_payco]}"
  	response = HTTParty.get(url)
    parsed = JSON.parse(response.body)
    puts parsed
  	if parsed["success"]
  		@data = parsed["data"]
  		@charge = Charge.where(uid: @data["x_id_invoice"]).take



      redirect_to url_for ([@charge.order.sender, @charge.order])
    else
  		@error = "Unable to retreive the information"
      redirect_to :root
  	end
  end


# WHY SOME HAVE @CHARGE AND OTHERS ONLY CHARGE

  def confirmation
    puts " ON CONFIRMATION "
  	charge = Charge.where(uid: params[:x_id_invoice]).take
  	if charge.nil?
  		head :unprocessable_entity
  		return
  	end

  	charge.update!(response_data: params.as_json, error_message: nil)
       
       puts " ON CONFIRMATION SIGNATURE IS  #{params[:x_signature]}"

  	if signature == params[:x_signature]

      puts " X-CODE RESPONSE #{params[:x_cod_response]}"
      puts "  PARAMS  #{params}"
  		update_status(charge, params[:x_cod_response])

      update_status(charge, params[:x_cod_transaction_state])
      puts "X COD TRANSACTION STATE !!! #{params[:x_cod_transaction_state]}"
  		update_payment_method(charge, params[:x_franchise])


      


      puts "X FRANCHISE  !!! #{params[:x_franchise]}"
  		head :no_content

        order = charge.order
        order.status = 'posted'    
        order.save

        puts "   Notification Sent to Sender #{@order.sender.id}"
        NotificationChannel.broadcast_to(@order.sender,
              title: 'Notificación', 
              body: "Pago Aceptado. El Estado de la <a href=""#{url_for([@order.sender, @order])}""> orden No: #{@order.id.to_s} </a>, 
                    ha cambiado.")



  	else
  		puts "Signature if doesn't match: #{signature}"
  		puts "Received signature: #{params[:x_signature]}"
  		head :unprocessable_entity
  	end
  end

  private

  	def signature
  		msg = "#{params[:x_cust_id_cliente]}^#{ENV['EPAYCO_P_KEY']}^#{params[:x_ref_payco]}^#{params[:x_transaction_id]}^#{params[:x_amount]}^#{params[:x_currency_code]}"
  		Digest::SHA256.hexdigest(msg)
  	end

  	def update_status(charge, status)
      puts " UPADTING STATUS !!"
  		if status == '1'
  			charge.paid!

        #order = charge.order
        #order.status = 'posted'    
        #order.save
#
        #puts "   Notification Sent to Sender #{@order.sender.id}"
        #NotificationChannel.broadcast_to(@order.sender,
        #      title: 'Notificación', 
        #      body: "Pago Aceptado. El Estado de la <a href=""#{url_for([@order.sender, @order])}""> orden No: #{@order.id.to_s} </a>, 
        #            ha cambiado.")

  		elsif status == '2' || status == '4'
  			charge.update!(status: :rejected, error_message: params[:x_response_reason_text])
  		elsif status == '3'
  			charge.pending!
  		else
  			head :unprocessable_entity
  			return
  		end
  	end

  	def update_payment_method(charge, payment_method)
  		if ['VS', 'MC', 'DC', 'CR', 'AM'].include?(payment_method)
  			charge.credit_card!
  		elsif payment_method == 'PSE'
  			charge.pse!
  		else
  			charge.referenced!
  		end
  	end

end
