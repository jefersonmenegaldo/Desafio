unit ProjetoPokemon.Repository.UBaseRepository;

interface

uses Rest.Client, Rest.Json, System.Generics.Collections, System.Classes;

type
  TBaseRepository<T: class, constructor> = class abstract (TInterfacedObject)
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
  public
    function Execute(const aResource: string): TList<T>;  overload;
    constructor Create;
    destructor Destroy; override;
  end;

const BASE_URL: string = 'https://pokeapi.glitch.me/v1';

implementation

uses
  REST.Types, System.JSON;

{ TBaseRepository<T> }
constructor TBaseRepository<T>.Create;
begin
  FRESTClient := TRESTClient.Create(nil);
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);

  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;

  inherited;
end;

destructor TBaseRepository<T>.Destroy;
begin
  FRESTClient.Free;
  FRESTRequest.Free;
  FRESTResponse.Free;

  inherited;
end;

function TBaseRepository<T>.Execute(const aResource: string): TList<T>;
var
  FJsonResult:  TJsonValue;
  FJsonArray: TJSONArray;
  i: integer;
begin
  Result := TList<T>.create;

  FRESTClient.BaseURL := BASE_URL;
  FRESTRequest.Resource := aResource;
  FRESTRequest.Method := rmGET;

  try
    FRESTRequest.Execute;
    if FRESTRequest.Response.StatusCode <> 200 then
      Exit;

    FJsonResult := TJSONObject.ParseJSONValue(FRESTRequest.Response.Content);
    FJsonArray := FJsonResult.GetValue<TJSONArray>('');

    for I := 0 to FJsonArray.Count - 1 do
      Result.Add( Tjson.JsonToObject<T>(FJsonArray.Items[i].ToJSON));

  finally
    FJsonResult.Free;
  end;

end;

end.
