defmodule MassaProxy.Server.Dispatcher do
  @moduledoc """
  This module is the entrypoint of all gRPC requests for all protocols
  """
  require Logger
  alias MassaProxy.Protocol.EventSourced.Handler, as: EventSourcedHandler
  alias MassaProxy.Protocol.Action.Handler, as: ActionHandler

  def dispatch(
        %{
          entity_type: entity_type,
          persistence_id: persistence_id,
          message: message,
          stream: stream
        } = payload
      ) do
    Logger.info(
      "Handle request for entity type #{inspect(entity_type)}. Message: #{inspect(message)}"
    )

    Logger.debug(
      "Handle stream: #{inspect(stream)}. With persistence id: #{inspect(persistence_id)}"
    )

    case entity_type do
      "cloudstate.action.ActionProtocol" -> ActionHandler.handle(payload)
      "cloudstate.eventsourced.EventSourced" -> EventSourcedHandler.handle(payload)
      _ -> Logger.error("Not Implemented Entity type #{entity_type}")
    end
  end
end
