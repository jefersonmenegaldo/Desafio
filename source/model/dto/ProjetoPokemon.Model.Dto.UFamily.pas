unit ProjetoPokemon.Model.Dto.UFamily;

interface

uses
  System.Generics.Collections;

type
  TFamilyDTO = class
  private
    FId: integer;
    FEvolutionStage: integer;
    FEvolutionLine: TList<string>;
  public
    constructor Create;
    Destructor Destroy; override;

    property Id: integer read FId write FId;
    property EvolutionStage: integer read FEvolutionStage write FEvolutionStage;
    property EvolutionLine: TList<string> read FEvolutionLine write FEvolutionLine;
  end;

implementation

{ TFamilyDTO }

constructor TFamilyDTO.Create;
begin
  FEvolutionLine := TList<string>.create;
end;

destructor TFamilyDTO.Destroy;
begin
  FEvolutionLine.Free;
  inherited;
end;

end.
