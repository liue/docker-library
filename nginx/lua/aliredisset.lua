local function close_redis(red)
       if not red then
      		return
       end
       local pool_max_idle_time = 10000 
       local pool_size = 512 
       local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)
--	 local ok, err = red:close();
       if not ok then
     	--   ngx.say("set keepalive error : ", err)
       end
end  


local alired = require "resty.redis";
local aliredis = alired.new();
aliredis:set_timeout(1000);
local ok,err = aliredis.connect(aliredis,"5940e1cf4a8b4c19.m.cnhza.kvstore.aliyuncs.com","6379");
if not ok then  
--    ngx.say("connect to redis error : ", err)  
    return ; 
end  


ok, err = aliredis:auth("HLhxRr5VqGEb")
   if not ok then
      --  ngx.say("failed to authenticate: ", err)
        return close_redis(aliredis);
   end


local setcachekey = ngx.var.cachekey;
local setexptime = ngx.var.exptime;
--local asdcache = aliredis:exists(setcachekey);
--if (asdcache == 0) then
	aliredis:set(setcachekey,ngx.var.echo_request_body);
	aliredis:expire(setcachekey,setexptime);
	return close_redis(aliredis);
--end 

