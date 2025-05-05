defmodule RespawnedWeb.Router do
  use RespawnedWeb, :router

  import RespawnedWeb.Auth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    # Controllers default layout
    plug :put_layout, html: {RespawnedWeb.Layouts, :public}
    # All default root layout
    plug :put_root_layout, html: {RespawnedWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_account
    plug :fetch_current_profile
    # plug :check_onboarding
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :onboarding do
    plug :check_onboarding
  end

  pipeline :authenticated do
    plug :ensure_authenticated
  end

  scope "/", RespawnedWeb do
    pipe_through :browser

    live "/", HomeLive

    scope "/auth" do
      post "/", SessionController, :create

      live_session :public, layout: {RespawnedWeb.Layouts, :public} do
        live "/sign-in", Auth.SignInLive
        live "/sign-up", Auth.SignUpLive
      end
    end

    #  authenticated routes
    scope "/" do
      pipe_through :authenticated

      live "/onboarding", OnboardingLive
      post "/profiles", ProfileController, :create

      put "/auth", SessionController, :update
      delete "/auth", SessionController, :delete

      # routes that need onboarding check
      scope "/" do
        pipe_through :onboarding

        live "/profiles", ProfilesLive, :index
        live "/profiles/new", ProfilesLive, :new

        scope "/communities" do
          live_session :communities, layout: {RespawnedWeb.Layouts, :communities} do
            live "/", Communities.IndexLive
            live "/new", Communities.NewLive
            live "/:id", Communities.ShowLive
          end

          scope "/:id" do
            live_session :community_management,
              layout: {RespawnedWeb.Layouts, :community_management},
              on_mount: RespawnedWeb.CurrentCommunityHook do
              live "/info", Communities.Management.InfoLive
              live "/managers", Communities.Management.ManagersLive
              live "/settings", Communities.Management.SettingsLive
            end
          end
        end

        live_session :guilds, layout: {RespawnedWeb.Layouts, :guilds} do
        end
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RespawnedWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:respawned, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RespawnedWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
