unit ProjetoPokemon.Model.Dto.UPokemon;

interface

uses
  System.Generics.Collections, ProjetoPokemon.Model.Dto.UAbilities,
  ProjetoPokemon.Model.Dto.UFamily;

type
  TPokemonDTO = class
  private
    FNumber: string;
    FName: string;
    FSpecies: string;
    FAbilities: TAbilitiesDTO;
    FHeight: string;
    FWeight: string;
    FFamily: TFamilyDTO;
    FStarter: boolean;
    FLegendary: boolean;
    FMythical: boolean;
    FUltraBeast: boolean;
    FMega: boolean;
    FGen: integer;
    FSprite: string;
    FDescription: string;
  public

    property Number: string read FNumber write FNumber;
    property Name: string read FName write FName;
    property Species: string read FSpecies write FSpecies;
    property Abilities: TAbilitiesDTO read FAbilities write FAbilities;
    property Height: string read FHeight write FHeight;
    property Weight: string read FWeight write FWeight;
    property Family: TFamilyDTO read FFamily write FFamily;
    property Starter: boolean read FStarter write FStarter;
    property Legendary: boolean read FLegendary write FLegendary;
    property Mythical: boolean read FMythical write FMythical;
    property UltraBeast: boolean read FUltraBeast write FUltraBeast;
    property Mega: boolean read FMega write FMega;
    property Gen: integer read FGen write FGen;
    property Sprite: string read FSprite write FSprite;
    property Description: string read FDescription write FDescription;

    constructor Create;
    Destructor Destroy; override;
  end;

implementation
   
{ TPokemonDTO }
constructor TPokemonDTO.Create;
begin
  FAbilities := TAbilitiesDTO.create;
  FFamily := TFamilyDTO.create;
end;

destructor TPokemonDTO.Destroy;
begin
  FAbilities.Free;
  FFamily.Free;
  inherited;
end;
end.
