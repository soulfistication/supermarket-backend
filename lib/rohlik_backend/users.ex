defmodule RohlikBackend.Users do
  @moduledoc false

  use Agent

  @seed_user %{
    id: 1,
    email: "martin.stekl@gmail.com",
    password: "thebestpasswordever",
    name: "Martin Štekl",
    phone: "+420728778677"
  }

  def start_link(_opts) do
    Agent.start_link(fn -> %{users: [@seed_user], next_id: 2} end, name: __MODULE__)
  end

  def register(attrs) do
    Agent.get_and_update(__MODULE__, fn state ->
      case find_by_email(state.users, attrs.email) do
        nil ->
          user = %{
            id: state.next_id,
            email: attrs.email,
            password: attrs.password,
            name: attrs.name,
            phone: attrs.phone
          }

          {user, %{state | users: state.users ++ [user], next_id: state.next_id + 1}}

        existing ->
          {existing, state}
      end
    end)
  end

  def find_by_credentials(email, password) do
    Agent.get(__MODULE__, fn state ->
      Enum.find(state.users, fn user ->
        user.email == email and user.password == password
      end)
    end)
  end

  defp find_by_email(users, email) do
    Enum.find(users, fn user -> user.email == email end)
  end
end
