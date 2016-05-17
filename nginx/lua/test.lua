local function testclose_redis(red)
       if not red then
      		return
       end
--       local pool_max_idle_time = 10000 
--       local pool_size = 512 
--       local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)
	 local ok, err = red:close();
       if not ok then
     	--   ngx.say("set keepalive error : ", err)
       end

end  


local red = require "resty.redis";
--local cjson = require "cjson";
local redis = red.new();
redis:set_timeout(1000);
local ok,err = redis.connect(redis,"5940e1cf4a8b4c19.m.cnhza.kvstore.aliyuncs.com","6379");
if not ok then  
--    ngx.say("connect to redis error : ", err)  
    return ; 
end  


ok, err = redis:auth("HLhxRr5VqGEb")
   if not ok then
      --  ngx.say("failed to authenticate: ", err)
         testclose_redis(redis);
   end


local getcachekey = ngx.var.cachekey;

local asdcache = redis:exists(getcachekey);
if (asdcache == 0) then
	return testclose_redis(redis);
end 
local res,err =  redis:get(getcachekey);
   if not res then
	return  testclose_redis(cache);
   
else 
	testclose_redis(redis);
	ngx.say(res);
end

