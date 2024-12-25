(()=>{
    console.log("Initializing...\n");

    const FS = require("node:fs");
    const PATH = require("node:path");
    const CRYPTO = require("crypto");

    const GetHash = async(filePath)=>{
        return await new Promise((resolve, reject)=>{
            const hash = CRYPTO.createHash("sha256");
            const stream = FS.createReadStream(filePath);

            stream.on("data", (chunk)=>{
                hash.update(chunk);
            });

            stream.on("end", ()=>{
                resolve(hash.digest('hex'));
            });

            stream.on("error", (err)=>{
                reject(err);
            });
        });
    };


    const Setup = ()=>{
        const path_0 = PATH.join(__dirname);
        const path_1 = PATH.join("/");
        const path_2 = PATH.join(__dirname, "__");

        const list_0 = [path_0];
        const list_1 = [path_1];

        let count = 0;

        const Compare = async(filepath_0, filepath_1, path_0, path_1)=>{
            //console.log(filepath_0);
            const isExist_0 = FS.existsSync(filepath_0);
            const isExist_1 = FS.existsSync(filepath_1);

            if(isExist_0 && isExist_1){
                const hash_0 = GetHash(filepath_0);
                const hash_1 = GetHash(filepath_1);
                const isDifferent = hash_0 !== hash_1;
                //console.log(isDifferent);
            }else if(isExist_0){
                FS.copyFile(filepath_0, filepath_1, (err)=>{
                    if(err)return console.log("KOPYALANAMADI !!!");
                    console.log(filepath_1, " dosya oluşturuldu");
                });
                return console.log("DOSYA YOK 0 => ", filepath_1);
            }else if(isExist_1){
                FS.copyFile(filepath_1, filepath_0, (err)=>{
                    if(err)return console.log("KOPYALANAMADI !!!");
                    console.log(filepath_0, " dosya oluşturuldu");
                });
                return console.log("DOSYA YOK 1 => ", filepath_0);
            }
        };

        const SearchDir = (path_0, path_1)=>{
            FS.readdir(path_0, (err, data)=>{
                if(err)return console.log("\n\n", err, "\n\n");
                data.map((filename)=>{
                    const filepath_0 = PATH.join(path_0, filename);
                    const filepath_1 = PATH.join(path_1, filename);
                    if(FS.existsSync(filepath_0)){

                        const stat = FS.statSync(filepath_0);
                        if(stat.isDirectory()){
                            list_0.push(filepath_0);
                            list_1.push(filepath_1);
                        }else if(stat.isFile()){
                            Compare(filepath_0, filepath_1, path_0, path_1);
                        }
                    }else{
                        console.log("YOL BOZUK => ", filepath_0);
                        return;
                        FS.unlink(filepath_0, (err)=>{
                            if(err)return console.log("SİLİNEMEDİ!!!");
                        });
                    }
                });
            });
        };

        const SearchOrder = (n=0)=>{
            const path_0 = list_0[n] + "";
            const path_1 = list_1[n] + "";
            console.log("SEARCH => ", n);
            SearchDir(path_0, path_1);
            return true;
        };

        setInterval(()=>{
            SearchOrder(count);
            if(count >= list_0.length){
                console.log("BYE BYE");
                process.exit(0);
                return false;
            }
            count++;
        },10);
    };

    setTimeout(()=>{
        Setup();
    }, 100);

    console.log("Starting...\n");
})();
