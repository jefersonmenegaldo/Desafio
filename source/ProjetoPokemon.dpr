program ProjetoPokemon;

uses
  Vcl.Forms,
  ProjetoPokemon.View.UPrincipal in 'view\ProjetoPokemon.View.UPrincipal.pas' {FrmPrincipal},
  ProjetoPokemon.View.Ulnterfaces in 'interfaces\ProjetoPokemon.View.Ulnterfaces.pas',
  ProjetoPokemon.Model.Dto.UPokemon in 'model\dto\ProjetoPokemon.Model.Dto.UPokemon.pas',
  ProjetoPokemon.Model.Dto.UFamily in 'model\dto\ProjetoPokemon.Model.Dto.UFamily.pas',
  ProjetoPokemon.Model.Dto.UAbilities in 'model\dto\ProjetoPokemon.Model.Dto.UAbilities.pas',
  ProjetoPokemon.Repository.UPokemonRepository in 'repository\ProjetoPokemon.Repository.UPokemonRepository.pas',
  ProjetoPokemon.Repository.UBaseRepository in 'repository\ProjetoPokemon.Repository.UBaseRepository.pas',
  ProjetoPokemon.Repository.UImagemRepository in 'repository\ProjetoPokemon.Repository.UImagemRepository.pas';

{$R *.res}

begin

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
