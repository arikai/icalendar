defmodule ICalendar do
  @moduledoc """
  API for generating calendars in ICalendar (ICS) format

  Example:

    iex> use ICalendar
    ...> I.Calendar.new(
    ...>    name: "My cool name",
    ...>    description: value("My description", param: "Param value")
    ...>    some_recurring_prop: [
    ...>      "Value",
    ...>      value("Value with params", param: "Some param")
    ...>     ])
  """

  defdelegate encode(object), to: ICalendar.Component.Encoder
  # defdelegate decode(string), to: ICalendar.Decoder

  @doc """
  To create a Phoenix/Plug controller and view that output ics format:
  Add to your config.exs:
  ```
  config :phoenix, :format_encoders,
    ics: ICalendar
  ```
  In your controller use:
  `
    calendar = %ICalendar{ events: events }
    render(conn, "index.ics", calendar: calendar)
  `
  The important part here is `.ics`. This triggers the `format_encoder`.

  In your view can put:
  ```
  def render("index.ics", %{calendar: calendar}) do
    calendar
  end
  ```
  """
  defdelegate encode_to_iodata(object, options \\ []),
    to: ICalendar.Component.Encoder,
    as: :encode

  # TODO: add param to support inline-encoding with comma:
  # However, it should be noted that some properties
  # support encoding multiple values in a single property by separating
  # the values with a COMMA character.


  # cal_address and uri should be quoted
  # altrep delegated_from, delegated_to, dir, member, sent-by

  defmacro value(val, params) do
    params =
      case params do
        l when is_list(l) -> {:%{}, [], params}
        o -> Map.new(o)
      end

    quote do
      %ICalendar.Property.Value{
        value: unquote(val),
        params: unquote(params)
      }
    end
  end

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__), only: [value: 2]
      alias ICalendar, as: I
    end
  end
end
