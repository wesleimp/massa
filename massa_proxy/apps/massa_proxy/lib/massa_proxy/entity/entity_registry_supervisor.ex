defmodule MassaProxy.Entity.EntityRegistry.Supervisor do
  @moduledoc false
  use Supervisor

  def start_link(args \\ %{}) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(args) do
    children = [
      {Phoenix.PubSub, name: :entity_channel},
      MassaProxy.Entity.EntityRegistry.child_spec(%{})
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
