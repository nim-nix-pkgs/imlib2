{
  description = ''Simple wrapper of the Imlib2 library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."imlib2-master".dir   = "master";
  inputs."imlib2-master".owner = "nim-nix-pkgs";
  inputs."imlib2-master".ref   = "master";
  inputs."imlib2-master".repo  = "imlib2";
  inputs."imlib2-master".type  = "github";
  inputs."imlib2-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."imlib2-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}