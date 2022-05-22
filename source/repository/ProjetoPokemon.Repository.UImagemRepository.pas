unit ProjetoPokemon.Repository.UImagemRepository;

interface

uses
  ProjetoPokemon.View.Ulnterfaces, Vcl.Imaging.pngimage, Vcl.Graphics;

type
  TImagemRepository = class(TInterfacedObject, IImagemRepository)
  public
    function GetImagem(const aUrl: string): TBitmap;
    function ResizeImagem(const aData: TBitmap;
                                aHeight: Integer;
                                aWidth: Integer): TBitmap;

  end;


implementation

uses
  System.Net.HttpClient, System.Classes, System.SysUtils, Vcl.Forms;

{ TImagemRepository }
function TImagemRepository.GetImagem(const aUrl: string): TBitmap;
var
  FHttpClient: THttpClient;
  Fmemory : tMemoryStream;
  FPng : TPngImage;
begin
  Fmemory := tMemoryStream.Create;
  FPng := TPngImage.Create;
  try
    FHttpClient := THttpClient.Create;
    try
      FHttpClient.Get(aUrl, Fmemory);
    finally
      FreeAndNil(FHttpClient);
    end;
    FPng.LoadFromStream(Fmemory);
    result := TBitmap.Create;
    result.Assign(FPng);
  finally
    FreeAndNil(Fmemory);
    FreeAndNil(FPng);
  end;
end;

function TImagemRepository.ResizeImagem(const aData: TBitmap;
                                aHeight: Integer;
                                aWidth: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  try
    Result.Width := aWidth;
    Result.Height := aHeight;
    Result.Canvas.StretchDraw(Rect(0, 0, Result.Width-1, Result.Height-1), aData);
  except
    Result := nil;
  end;

end;

end.
