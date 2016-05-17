local redis = require "resty.redis"
local cache = redis.new()
local ok, err = cache.connect(cache, '10.168.70.140', '6379')
cache:set_timeout(1000)
if not ok then
       -- ngx.say("failed to connect:", err)
        return ngx.exit(500);
end
res, err = cache:set("redis-monitor", "success")
if not ok then
       -- ngx.say("failed to set monitor: ", err)
        return ngx.exit(501);
end
ngx.say("set result: ", res)
local res, err = cache:get("redis-monitor")
if not res then
       -- ngx.say("failed to get monitor: ", err)
        return ngx.exit(502);
end
if res == ngx.null then
       -- ngx.say("monitor not found.")
        return ngx.exit(503);
end
ngx.say("monitor: ", res)
local ok, err = cache:close()
if not ok then
       -- ngx.say("failed to close:", err)
 	return ngx.exit(504);
end


