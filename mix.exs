defmodule ICalendar.MixProject do
  use Mix.Project

  @version "0.6.1"

  def project do
    [
      app: :icalendar,
      version: @version,
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),

      name: "vobject",
      source_url: "https://github.com/polyfox/vobject",
      description: "Parse and manipulate iCalendar (RFC5545) and vCard objects (RFC6350)",
      package: [
        maintainers: ["Blaž Hrastnik"],
        licenses: ["MIT"],
        links: %{ "GitHub" => "https://github.com/polyfox/vobject" },
      ],
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp deps do
    [
      # Code style linter
      {:dogma, ">= 0.0.0", only: ~w(dev test)a},
      # Automatic test runner
      # {:mix_test_watch, ">= 0.0.0", only: :dev},

      # Markdown processor
      {:earmark, "~> 1.0", only: [:dev, :test]},
      # Documentation generator
      {:ex_doc, "~> 0.18", only: [:dev, :test]},

      # Benchmarks
      {:benchee, "~> 0.11", only: :dev},
      {:benchee_html, "~> 0.4", only: :dev},

      # Timezones, period parsing, intervals
      {:timex, "~> 3.0"},
      {:calendar, "~> 0.17.2"},

      # Generating Calendar UID
      {:elixir_uuid, "~> 1.2"},

      {:eflame, "~> 1.0.1", only: :dev}
    ]
  end
end
