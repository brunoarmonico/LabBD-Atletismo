package model;

public class Prova {
	private int idProva;
	private String nomeProva;
	private String sexo;
	public String getNomeProva() {
		return nomeProva;
	}
	public void setNomeProva(String nomeProva) {
		this.nomeProva = nomeProva;
	}
	public String getSexo() {
		if ("m".equals(sexo)) {
			return "Masculino";
		}
		else {
			return "Feminino";
		}
	}
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}
	public int getIdProva() {
		return idProva;
	}
	public void setIdProva(int idProva) {
		this.idProva = idProva;
	}
	
}
