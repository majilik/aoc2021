defmodule Main do
    def parse_file(filename) do
        File.stream!(filename, [], :line)
        |> Stream.map(&String.trim/1)
        |> Stream.map(&parse_line/1)
    end

    def parse_line(line) do
        line
        |> String.graphemes
        |> Enum.map(&String.to_integer/1)
    end

    def run1(filename) do
        parse_file(filename)
        |> solution1
    end

    def run2(filename) do
        parse_file(filename)
        |> solution2
    end

    def transpose([]), do: []
    def transpose([[]|_]), do: []
    def transpose(list) do
        [Enum.map(list, &hd/1) | transpose(Enum.map(list, &tl/1))]
    end

    def solution1(list) do
        freq_list = list
        |> transpose
        |> Enum.map(&Enum.frequencies/1)

        gamma = freq_list
        |> extract_most_freq
        |> Enum.join
        |> String.to_integer(2)

        epsilon = freq_list
        |> extract_least_freq
        |> Enum.join
        |> String.to_integer(2)

        gamma * epsilon
    end

    def extract_most_freq(list) do
        list 
        |> Enum.map(fn x -> Map.to_list(x)
            |> Enum.max_by(&(elem(&1, 1))) 
            |> elem(0)
            end)
    end

    def extract_least_freq(list) do
        list 
        |> Enum.map(fn x -> Map.to_list(x)
            |> Enum.min_by(&(elem(&1, 1))) 
            |> elem(0)
            end)
    end


    def solution2(list) do
        list
    end
end