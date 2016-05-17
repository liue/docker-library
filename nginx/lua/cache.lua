local function close_redis(red)
    if not red then
        return
    end
local pool_max_idle_time =10000 
local pool_size =100 
local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)  
    if not ok then  
        ngx.say("set keepalive error : ", err)  
    end  
end
 


local redis = require "resty.redis";
--local cjson = require "cjson";
local cache = redis.new();
cache:set_timeout(1000);
local ok,err = cache.connect(cache,"192.168.1.42","6379");
if not ok then
	return close_redis(cache);
end

local cachekey = ngx.var.cachekey;
local requesturi = ngx.var.cacheuri;
local expiretime = ngx.var.expire_time;
local dvtime = ngx.var.dv_time;
local cachelist =ngx.var.cachelist;

local statskey = "stats"..cachekey;
local scache = cache:exists(statskey);
if scache == 0  then
        cache:init_pipeline();
	cache:rpush(cachelist,requesturi);
        cache:set(statskey,requesturi);
        cache:expire(statskey,dvtime);
	cache:commit_pipeline();
end

local cachetime = cache:ttl(statskey);
--local cachetime = cache:ttl(requesturi);
local dvalue = tonumber(expiretime) - tonumber(cachetime);
local statsdata = {} ;
statsdata["requesturi"] = requesturi;
statsdata["date"] = os.date();
statsdata["expiretime"] = expiretime;
statsdata["dvtime"] = dvtime;
statsdata["cachetime"] = cachetime;
--cache:set("cachestats",cjson.encode(statsdata));


--if tonumber(dvalue) > tonumber(dvtime) then
         cache:rpush("cachelist",requesturi)
--end


