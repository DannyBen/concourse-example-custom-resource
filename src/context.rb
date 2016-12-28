require 'json'

class Context
  attr_reader :major, :minior

  def initialize
    input = JSON.parse(STDIN.gets)
    @source = input["source"] || {}
    @version = input["version"] || {}
    @params = input["params"] || {}
    @version = @version["version"] || @params["version"] || "0.0"
    @major, @minior = @version.to_s.split(".")
    @dest = ARGV[0]
  end

  def uri
    @source["uri"]
  end

  def version
    "#{@major || 0}.#{@minior || 0}"
  end

  def write(filename, data)
    path = File.join(@dest, filename)
    File.write(path, data)
  end

  def read(filename)
    path = File.join(@dest, filename)
    File.read(path)
  end
end
