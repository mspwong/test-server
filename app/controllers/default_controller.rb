class DefaultController < ApplicationController

  def post_hash
    p '******************** post_hash'
    puts params
    puts params.class

    p '********************************* getting payload'
    payload = params[:payload]
    p payload
    p payload.class

    extract_payload payload

    do_work("processing hash")

    render text: "OK", status: 200
    
  end

  def post_json
    p '******************** post json'
    puts params
    puts params.class

    p '********************************* getting payload'
    payload = params[:payload]
    p payload
    p payload.class
    #payload = JSON.parse(rows)

    extract_payload payload

    do_work("processing json")

    render text: "OK", status: 200
  end

  def do_work(message)
    PrintWorker.perform_async("#{message}")
  end

  private

  def deserialize_time hash
    hash[:created_at] = hash[:created_at].is_a?(String)  ?  Time.at(hash[:created_at].to_i)  :  Time.at(hash[:created_at])
    hash[:updated_at] = hash[:updated_at].is_a?(String)  ?  Time.at(hash[:updated_at].to_i)  :  Time.at(hash[:updated_at])
  end

  def extract_payload payload
    p '********************************* extracting payload'
    if (payload.is_a? String)
      extract_payload_string payload
    elsif (payload.is_a? Array)
      extract_payload_rows payload
    end
  end

  def extract_payload_rows payload
    p '********************************* iterating payload'
    payload.each do |row|
      deserialize_time row
      p row
      p row.class
      p row[:name]
      p row[:product_id]
    end
  end

  def extract_payload_string payload
    p '********************************* converting string'
    hash = eval(payload).with_indifferent_access
    deserialize_time hash
    puts hash.inspect
    p hash.class
    p hash[:name]
    p hash[:product_id]
  end

end