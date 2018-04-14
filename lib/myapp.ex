defmodule Myapp do
  @moduledoc """
  Documentation for Myapp.
  """
  use Application
  use Supervisor

  @doc """
  :one_for_one strategy. With this process, if the child process terminates, it will be restarted
  """
  def start(_type, _args) do
    Supervisor.start_link([{Myapp.Router, []}, {Myapp.ApiHandler, []}], strategy: :one_for_one)
  end
end
