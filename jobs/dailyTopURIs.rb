SCHEDULER.every '60s' do
    data = Net::HTTP.get_response(URI("http://localhost:2080/render?target=highestCurrent(daily.uri.*,10)&format=json&from=yesterday"))
    jsonData = JSON.parse(data.body)
    puts jsonData

    topUris = {}

    jsonData.each do |e|
        target = e['target']
        decoded = Base64.decode64(target)
        datapoint = e['datapoints'][0][0]

        topUris[decoded] = { label: decoded, value: datapoint }
    end

    send_event('dailyTopURIs', { items: topUris })

end
