defmodule SideSwipe.Repo do
  use Ecto.Repo,
    otp_app: :side_swipe,
    adapter: Ecto.Adapters.Postgres
end
