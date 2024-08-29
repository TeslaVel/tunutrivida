# app/channels/clients_channel.rb
class GlobalEvents < ApplicationCable::Channel
  def subscribed
    ch_name = "global_events_tunutrivida"

    stream_from ch_name
    puts "############ BCKEND Global Event Listenin #{ch_name} Params #{params}"

    # return unless params[:client_id].present?
    # client = SocketClient.find_by(clients_channel_id: params[:client_id])
    # unless client.present?
    #   SocketClient.create(client_channel_id: params[:client_id])
    # end

    # para transmitir mensajes de la conversación especificada a todos los suscriptores del canal
    # stream_for conversation

    # Transmitir el listado de clientes conectados a todos los clientes

    # ActionCable.server.broadcast('clients', clients: connected_clients)
  end

  def receive(data)
    puts "############  BCKEND Global Event data RECIBIDA ## #{data}"
    # html = render_to_string(partial: 'messages/message', locals: { message: message })
    # ActionCable.server.broadcast 'chat_channel', message: html
  end

  def unsubscribed
    # Eliminar al cliente que se desconecta del listado de clientes conectados
    # $redis.srem('connected_clients', @client_id)
    # SocketClient.find_by(client_channel_id: params[:client_id]).destroy

    # Transmitir el listado actualizado de clientes conectados a todos los clientes
    # ActionCable.server.broadcast('clients', clients: connected_clients)
  end

  private

  # def render_partial(data)
  #   # Renderiza la vista parcial y devuelve su contenido
  #   view_context.render(partial: "my_partial", locals: { data: data })
  # end

  # def view_context
  #   # Crea una instancia de ActionView::Base con el contexto actual
  #   @view_context ||= MiejemploController.view_context_class.new(Rails.application.routes.url_helpers, {})
  # end
end
