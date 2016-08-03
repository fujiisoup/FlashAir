require("Settings")

local ftpstring = "ftp://"..user..":"..passwd.."@"..server.."/"..serverDir.."/"
local lockdir = "/uploaded/"   -- trailing slash required, and folder must already exist

function exists(path)
    if lfs.attributes(path) then
        return true
    else
        return false
    end
end

function is_uploaded(path)
    local hash = fa.hash("md5", path, "")
    return exists(lockdir .. hash)
end

function set_uploaded(path)
    local hash = fa.hash("md5", path, "")
    local file = io.open(lockdir .. hash, "w")
    file:close()
end

function delete(path)
    -- Both of the following methods cause the next photo to be lost / not stored.
    fa.remove(path)
    -- fa.request("http://127.0.0.1/upload.cgi?DEL="..path)
end

function upload_file(folder, file)
    local path = folder .. "/" .. file
    -- Open the log file
    local outfile = io.open(logfile, "a")
    outfile:write(file .. " ... ")
    local response = fa.ftp("put", ftpstring..file, path)

    --Check to see if it worked, and log the result!
    if response ~= nil then
        print("Success!")
        outfile:write(" Success!\n")
        set_uploaded(path)
        if delete_after_upload == true then
            print("Deleting " .. file)
            outfile:write("Deleting " .. file .. "\n")
            sleep(1000)
            delete(path)
            sleep(1000)
        end
    else
        print(" Fail ")
        outfile:write(" Fail\n")
    end
    --Close our log file
    outfile:close()
end

function walk_directory(folder)
    -- Recursively iterate filesystem
    for file in lfs.dir(folder) do
        local path = folder .. "/" .. file
        local attr = lfs.attributes(path)
        print( "Found "..attr.mode..": " .. path )

        if attr.mode == "file" then
            if not is_uploaded(path) then
                upload_file(folder, file)
            else
                print(path .. " previously uploaded, skipping")
            end
        elseif attr.mode == "directory" then
            print("Entering " .. path)
            walk_directory(path)
        end
    end
end

-- wait for wifi to connect
while string.sub(fa.ReadStatusReg(),13,13) ~= "a" do
    print("Wifi not connected. Waiting...")
    sleep(1000)
end
walk_directory(folder)
