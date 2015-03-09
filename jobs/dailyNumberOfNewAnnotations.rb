SCHEDULER.every '60s' do
    data = Net::HTTP.get_response(URI("http://localhost:2080/render?target=daily.annotations.new&format=json&from=yesterday"))
    jsonData = JSON.parse(data.body)
    puts jsonData
    total = jsonData[0]['datapoints'][0][0]
    puts total
    send_event('dailylNumberOfNewAnnotations', { current: total})

end
