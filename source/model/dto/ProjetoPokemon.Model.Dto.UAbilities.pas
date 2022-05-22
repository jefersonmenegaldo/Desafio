unit ProjetoPokemon.Model.Dto.UAbilities;

interface

uses
  System.Generics.Collections;

type
  TAbilitiesDTO = class
  private
    FNormal: TList<string>;
    FHidden: TList<string>;

  public
    property Normal: TList<string> read FNormal write FNormal;
    property Hidden: TList<string> read FHidden write FHidden;

    constructor Create;
    Destructor Destroy; override;

  end;

implementation

{ TAbilitiesDTO }
constructor TAbilitiesDTO.Create;
begin
  FNormal := TList<string>.create;
  FHidden := TList<string>.create;
end;

destructor TAbilitiesDTO.Destroy;
begin
  FHidden.Free;
  FNormal.Free;
  inherited;
end;

end.
