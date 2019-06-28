defmodule FoodiesWeb.Resolvers.Accounts do
  alias Foodies.Accounts
  alias FoodiesWeb.Schema.ChangesetErrors

  def signin(_, %{email: email, password: password}, _) do
    case Accounts.authenticate_by_email_and_pass(email, password) do
      :error ->
        {:error, "Whoops, invalid credentials!"}

      {:ok, user} ->
        token = FoodiesWeb.AuthToken.sign(user)
        {:ok, %{token: token, user: user}}
    end
  end

  def signup(
        _,
        %{name: name, username: username, email: email, password: password, role: role},
        _
      ) do
    user_info = %{
      name: name,
      username: username,
      credential: %{
        email: email,
        password: password,
        role: role
      }
    }

    case Accounts.register_user(user_info) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create account", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        token = FoodiesWeb.AuthToken.sign(user)
        {:ok, %{token: token, user: user}}
    end
  end

  def me(_, _, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_, _, _) do
    {:ok, nil}
  end
end
