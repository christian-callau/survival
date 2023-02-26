defmodule SurvivalWeb.PageController do
  use SurvivalWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false, current_user: get_session(conn, :current_user))
  end

  def login(conn, _params) do
    render(conn, :login, layout: false)
  end
end
