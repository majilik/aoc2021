defmodule Main do
    def parse_file(filename) do
        File.stream!(filename, [], :line)
        |> Stream.map(&String.trim/1)
        |> Stream.map(&String.to_integer/1)
    end

    def run1(filename) do
        parse_file(filename)
        |> solution1
    end

    def run2(filename) do
        parse_file(filename)
        |> solution2
    end

    def solution1(list) do
        list
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.map(fn ([a, b|_]) -> b - a end)
        |> Enum.filter(&(&1 > 0))
        |> Enum.count()
    end

    def solution2(list) do
        list
        |> Enum.chunk_every(3, 1, :discard)
        |> Enum.map(&Enum.sum/1)
        |> solution1
    end
end