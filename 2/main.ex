defmodule Main do
    def parse_file(filename) do
        File.stream!(filename, [], :line)
        |> Stream.map(&String.trim/1)
        |> Stream.map(&parse_line/1)
    end

    def parse_line(line) do
        line
        |> String.split()
        |> (fn ([direction, value]) -> {
            String.to_atom(direction),
            String.to_integer(value)
        } end).()
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
        %{depth: depth, h_pos: h_pos} = list
        |> Enum.reduce(%{depth: 0, h_pos: 0}, &run_command/2)
        depth * h_pos
    end

    def run_command({:forward, value}, pos) do
       %{h_pos: h_pos} = pos
       %{pos | h_pos: h_pos + value} 
    end
    def run_command({:down, value}, pos) do
        %{depth: depth} = pos
        %{pos | depth: depth + value}
    end
    def run_command({:up, value}, pos) do
        %{depth: depth} = pos
        %{pos | depth: depth - value}
    end

    def solution2(list) do
        %{depth: depth, h_pos: h_pos} = list
        |> Enum.reduce(%{aim: 0, depth: 0, h_pos: 0}, &run_command2/2)
        depth * h_pos
    end

    def run_command2({:forward, value}, pos) do
       %{h_pos: h_pos, aim: aim, depth: depth} = pos
       %{pos | h_pos: h_pos + value, depth: depth + aim * value} 
    end
    def run_command2({:down, value}, pos) do
        %{aim: aim} = pos
        %{pos | aim: aim + value}
    end
    def run_command2({:up, value}, pos) do
        %{aim: aim} = pos
        %{pos | aim: aim - value}
    end
end