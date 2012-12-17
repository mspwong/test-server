class DefaultController < ApplicationController

  def post_hash
    p '******************** Got here'

    puts params
    puts params.class
    rows = params[:available_now] if params.keys.include? "available_now"
    #rows = params[:name]

    p '********************************* expecting hash'
    puts rows
    p rows
    p rows.class
    #hash = eval rows
    p '********************************* iterating hash'
    #puts rows["name"]
    rows.each do |row|
      p row['account_id']
    end

    render text: "OK", status: 200
  end

  def post_json
    p '******************** post json'

    puts params
    hash = params[:available_now] if params.keys.include? "available_now"

    p '********************************* expecting hash'
    p hash
    p hash.class
    #hash = JSON.parse(rows)
    p '********************************* iterating hash'
    hash.each do |row|
      p row['account_id']
    end


    render text: "OK", status: 200

  end

end