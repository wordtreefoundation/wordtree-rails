require 'httparty'
require 'nokogiri'

class HtmlParser < HTTParty::Parser
  SupportedFormats.merge!('text/html' => :html)

  def html
    Nokogiri::HTML(body)
  end
end

class Page
  include HTTParty
  parser HtmlParser
  attr_reader :book

  def initialize(book)
    @book = book
  end

  def html
    @html ||= self.class.get("http://openlibrary.org/search?q=#{@book}")
  rescue Exception => e
    @error = e
  end

  def name
    html.css("span.details .booktitle a").text
  end

  def year
    html.css("span.details .resultPublisher").text.scan(/\d\d\d\d/).first
  end
  
  def to_s
    html
    if @error
      "#{@book}\t\tERROR\t#{@error.to_s}"
    else
      "#{@book}\t#{year}\t#{name}"
    end
  end
end

=begin
    <span class="details">
        <span class="resultTitle">
            <h3 class="booktitle">
                <a href="/works/ia:olneyhymnsbyjne00cowpgoog/Olney_hymns_by_J._Newton_and_W._Cowper._."
                class="results">Olney hymns [by J. Newton and W. Cowper.].</a>
            </h3>
            <span class="bookauthor">by
            <em>Unknown author</em>
            </span>
            <span class="resultPublisher">
                1 edition
                (1 ebook)
                - first published in 
                1783
            </span>
        </span>
    </span>
=end

$stdin.each_line do |line|
  book = line.strip
  page = Page.new(book)
  puts page.to_s
  $stdout.flush
end
