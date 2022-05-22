unit ProjetoPokemon.View.UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, System.Net.HttpClient,
  ProjetoPokemon.View.Ulnterfaces, ProjetoPokemon.Model.Dto.UPokemon,
  ProjetoPokemon.Repository.UPokemonRepository, System.Generics.Collections,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TCarregamentoDados = class(TThread)
    private
        FProgress : TProgressBar;
        FLista : TList<TPokemonDTO>;
        FPokemonRepository : IRestBase<TPokemondto>;
        FListView : TListView;
        FImagemRepository : IImagemRepository;
        FListaImagens : TImageList;

        procedure GetAllPokemons;
        procedure Sincronizar;
    public
        constructor Create(aListaImagens: TImageList;
                           aListView: TListView;
                           aProgress : TProgressBar); reintroduce;
        destructor Destroy; override;
        procedure Execute; override;

    end;

  TFrmPrincipal = class(TForm)
    pnlHeader: TPanel;
    pnlFooter: TPanel;
    pnlBody: TPanel;
    btnSair: TSpeedButton;
    Image1: TImage;
    grid: TListView;
    pnlBtnAtualizar: TPanel;
    BtnAtualizar: TSpeedButton;
    FProgresso: TProgressBar;
    ListaImagens: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    CarregamentoDados: TCarregamentoDados;
    procedure CarregarDados;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  ProjetoPokemon.Repository.UImagemRepository;

{$R *.dfm}
procedure TFrmPrincipal.BtnAtualizarClick(Sender: TObject);
begin
  CarregarDados;
end;

procedure TFrmPrincipal.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmPrincipal.CarregarDados;
begin
  Grid.Items.Clear;
  CarregamentoDados := TCarregamentoDados.Create(ListaImagens, grid,FProgresso);
  CarregamentoDados.Start;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Position := poScreenCenter;
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  ListaImagens.Free;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  grid.SmallImages.Width := 150;
  grid.SmallImages.Height := 150;
  CarregarDados;
end;

{ TProcesso }
constructor TCarregamentoDados.Create(aListaImagens : TImageList;
                                      aListView : TListView;
                                      aProgress : TProgressBar);
begin
  inherited Create(True);
  FreeOnTerminate := True;

  FLista := TList<TPokemonDTO>.Create;
  FProgress := aProgress;
  FPokemonRepository := TPokemonRepository<TPokemondto>.Create;
  FListaImagens := aListaImagens;
  FListView := aListView;
  FImagemRepository := TImagemRepository.Create;
end;

destructor TCarregamentoDados.Destroy;
var i : Integer;
begin
  FProgress.Visible := False;
  Self.Queue(Self.Sincronizar);

  for I := 0 to FLista.Count -1 do
    FLista.Items[I].Free;

  if Assigned(FLista) then
    FreeAndNil(FLista);

  inherited;
end;

procedure TCarregamentoDados.Execute;
  function IIf(aExpression: Variant; aTrue, aFalse: Variant): Variant;
   begin
     if aExpression then
        Result := aTrue
     else
        Result := aFalse;
   end;
var
  I: Integer;
  FListaItem : TListItem;
  FBmp : TBitmap;
begin
  inherited;

  GetAllPokemons;

  FListaImagens.Clear;
  FProgress.Visible := true;
  FProgress.max := FLista.count;
  Self.Queue(Self.Sincronizar);

  for I := 0 to FLista.Count -1 do
    begin
      FListaItem := FListView.Items.Add;

      FBmp := FImagemRepository.GetImagem(FLista[i].sprite);
      FListaImagens.Add(FImagemRepository.ResizeImagem(FBmp,FListaImagens.Height,FListaImagens.Width),nil);

      with FListaItem do
        begin
          ImageIndex := I;

          SubItems.Add(
            Concat(
                    'Number.: ', Flista[i].Number,  Char(13),
                    'Name.: ', Flista[i].name,Char(13),
                    'Species.: ', Flista[i].Species, Char(13),
                    'Height.: ', Flista[i].Height, Char(13),
                    'Weight.: ', Flista[i].Weight, Char(13),
                    'Starter.: ', IIF( Flista[i].Starter , 'Yes','No'),
                    '  Legendary.: ', IIF( Flista[i].Starter , 'Yes','No'),
                    '  Mythical.: ', IIF( Flista[i].Mythical , 'Yes','No'),
                    '  UltraBeast.: ', IIF( Flista[i].UltraBeast , 'Yes','No'),
                    '  Mega.: ', IIF( Flista[i].Mega , 'Yes','No'), Char(13),
                    'Gen.: ', Flista[i].Gen.ToString
          ));
          SubItems.Add(  Flista[i].Description );
        end;
      Self.Queue(Self.Sincronizar);
      FreeAndNil(FBmp);
    end;
end;

procedure TCarregamentoDados.GetAllPokemons;
begin
  FLista := FPokemonRepository.GetAll;
end;

procedure TCarregamentoDados.Sincronizar;
begin
  FProgress.Position := FProgress.Position + 1;
end;

end.
