Code.eval_file("mess.exs")
defmodule CommonsPub.Access.MixProject do
  use Mix.Project

  def project do
    [
      app: :cpub_access,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: "Access-related models for commonspub",
      homepage_url: "https://github.com/commonspub/cpub_access",
      source_url: "https://github.com/commonspub/cpub_accesss",
      package: [
        licenses: ["MPL 2.0"],
        links: %{
          "Repository" => "https://github.com/commonspub/cpub_access",
          "Hexdocs" => "https://hexdocs.pm/cpub_access",
        },
      ],
      docs: [
        main: "readme", # The first page to display from the docs 
        extras: ["README.md"], # extra pages to include
      ],
      deps: deps()
    ]
  end

  def application, do: [ extra_applications: [:logger] ]

  defp deps do
    Mess.deps [{:ex_doc, ">= 0.0.0", only: :dev, runtime: false}]
  end

end
