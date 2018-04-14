defmodule Myapp.ApiHandler do
    use GenServer

    def init(args) do
        {:ok, args}
    end

    def start_link(_) do
        GenServer.start_link(__MODULE__, [], name: __MODULE__)
    end

    def get_character_request(id_or_name) do
        url = api_route("characters/#{id_or_name}/")
        case HTTPoison.get(url, [], []) do
          {:error, %HTTPoison.Error{reason: reason}} ->
            {:error, reason}
          {:ok, %HTTPoison.Response{body: body}} ->
            {:ok, body }
        end
    end

    defp api_route(path) do
        "https://anapioficeandfire.com/api/#{path}"
    end
    
    
    def get_character(id_or_name) do
        GenServer.call(__MODULE__, {:get_character, id_or_name})
    end

    def handle_call({:get_character, id_or_name}, _pid, state) do
        {:ok, response} = get_character_request(id_or_name)
        {:reply, response, state}
    end

    def handle_call(_term, _pid, state) do
        {:reply, [], state}
    end

    # def handle_info(term, state) do
    #     {:noreply, state}
    # end

    # def terminate(reason, state) do
    #     :ok
    # end

end