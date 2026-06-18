# 棱镜终端: 下一代配置器

## 使用方法

### 使用 Nix Flake

`flake.nix`:
```nix
{

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        prismterminal = {
            url = "github:HoshinoTented/nix-prismterminal";
            # 如果要让 nix-prismterminal 使用 nixpkgs 中的软件包的话就添加下面这行
            # inputs.nixpkgs.follow = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, prismterminal, ... }: {
        nixosConfigurations."your computer" = nixpkgs.lib.nixosSystem {
            modules = [
                ./configuration.nix
                prismterminal.nixosModules.prismterminal
            ];
        };
    }
}
```

`configuration.nix`:
```nix
{
    programs.prismterminal = {
        enable = true;
        # 如果你的猫盘型号没有被自动允许用户访问, 则可以在这里添加
        # 运行命令 `lsusb`, 找到猫盘对应的行, 把前面形如 `XXXX:YYYY` 的内容填入:
        udevExtra = [
            {
                name = "Your Meowpad Name";
                idVendor = "XXXX";
                idProduct = "YYYY";
            }
        ];
    };
}
```