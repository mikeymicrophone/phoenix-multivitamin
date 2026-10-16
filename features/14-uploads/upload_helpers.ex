defmodule PhoenixMultivitaminWeb.UploadHelpers do
  @moduledoc "Shared upload presentation and readiness checks; flight content stays in each slot."
  use Phoenix.Component

  import Phoenix.LiveView, only: [uploaded_entries: 2]

  def upload_form do
    {%{}, %{}}
    |> Ecto.Changeset.change()
    |> to_form(as: :upload)
  end

  def readiness(socket, name) do
    {completed, pending} = uploaded_entries(socket, name)

    cond do
      upload_errors(socket.assigns.uploads[name]) != [] -> :invalid
      Enum.any?(completed ++ pending, &(not &1.valid?)) -> :invalid
      pending != [] -> :in_progress
      completed == [] -> :empty
      true -> :ready
    end
  end

  def readiness_message(:empty), do: "Choose a file before filing."
  def readiness_message(:invalid), do: "Remove the refused file before filing."
  def readiness_message(:in_progress), do: "Wait for every transfer to finish."

  attr :id, :string, required: true
  attr :upload, Phoenix.LiveView.UploadConfig, required: true
  attr :cancel_event, :string, default: nil
  attr :preview, :boolean, default: false
  attr :rest, :global
  slot :detail

  def upload_queue(assigns) do
    ~H"""
    <section id={@id} class="space-y-3" aria-live="polite" {@rest}>
      <p :for={reason <- upload_errors(@upload)} role="alert" class="text-red-800">
        {upload_error(reason)}
      </p>
      <article :for={entry <- @upload.entries} id={"#{@id}-#{entry.ref}"}
        class="rounded-lg border border-stone-200 p-4">
        <p class="font-medium">{entry.client_name}</p>
        <.live_img_preview :if={@preview and entry.valid?} entry={entry}
          class="my-3 max-h-40 rounded-lg" />
        <progress id={"#{@id}-progress-#{entry.ref}"} value={entry.progress} max="100"
          aria-label={"Transfer of #{entry.client_name}"} class="w-full accent-green-900">
          {entry.progress}%
        </progress>
        <p :for={reason <- upload_errors(@upload, entry)} role="alert" class="text-red-800">
          {upload_error(reason)}
        </p>
        {render_slot(@detail, entry)}
        <button :if={@cancel_event} id={"#{@id}-cancel-#{entry.ref}"} type="button"
          phx-click={@cancel_event} phx-value-ref={entry.ref}
          class="mt-2 rounded border border-stone-300 px-3 py-1 transition hover:bg-stone-100">
          Withdraw {entry.client_name}
        </button>
      </article>
    </section>
    """
  end

  defp upload_error(:too_large), do: "This file exceeds the byte limit."
  defp upload_error(:not_accepted), do: "This file type is not accepted."
  defp upload_error(:too_many_files), do: "Too many files are queued."
  defp upload_error(:external_client_failure), do: "The archive transfer failed. Withdraw and retry."
  defp upload_error(_reason), do: "The transfer failed. Withdraw and retry."
end
