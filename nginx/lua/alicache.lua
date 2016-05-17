local function close_redis(red)
       if not red then
      		return
       end
       local pool_max_idle_time = 10000 
       local pool_size = 512 
       local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)
--      local ok, err = red:close(); 
      if not ok then
     	   ngx.say("set keepalive error : ", err)
       end

end  


local redis = require "resty.redis";
local cache = redis.new();
cache:set_timeout(1000);
local ok,err = cache.connect(cache,"5940e1cf4a8b4c19.m.cnhza.kvstore.aliyuncs.com","6379");
if not ok then  
    ngx.say("connect to redis error : ", err)  
    return ; 
end  

ok, err = cache:auth("HLhxRr5VqGEb")
   if not ok then
        ngx.say("failed to authenticate: ", err)
        return close_redis(cache);
   end


local cachekey = ngx.var.cachekey;
local requesturi = ngx.var.cacheuri;
local expiretime = ngx.var.expire_time;
local dvtime = ngx.var.dv_time;
local cachelist =ngx.var.cachelist;

local ascache = cache:exists(cachekey);
if (ascache == 0) then
	return close_redis(cache);
end 
local statskey = "stats"..cachekey;
local scache = cache:exists(statskey);
if scache == 0  then
	cache:init_pipeline();
        cache:rpush(cachelist,requesturi);
        cache:set(statskey,requesturi);
        cache:expire(statskey,dvtime);
	cache:commit_pipeline();
end

close_redis(cache);



