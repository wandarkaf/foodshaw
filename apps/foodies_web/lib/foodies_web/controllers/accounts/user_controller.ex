defmodule FoodiesWeb.Accounts.UserController do
  use FoodiesWeb, :controller

  alias Foodies.Accounts
  alias Foodies.Accounts.User

  action_fallback FoodiesWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      # send_resp(conn, :no_content, "")
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.accounts_user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    case user do
      nil ->
        send_resp(conn, 404, "Not User found")

      _ ->
        {:ok, user}

        with {:ok, %User{}} <- Accounts.delete_user(user) do
          conn
          |> send_resp(:no_content, "")
        end
    end
  end
end
