package model;

public class ResultadoEvento {
	
	private int idAtleta;
	private String atleta;
	private String pais;
	private String resultado;
	private String posicao;
	public int getIdAtleta() {
		return idAtleta;
	}
	public void setIdAtleta(int idAtleta) {
		this.idAtleta = idAtleta;
	}
	public String getAtleta() {
		return atleta;
	}
	public void setAtleta(String atleta) {
		this.atleta = atleta;
	}
	public String getPais() {
		return pais;
	}
	public void setPais(String pais) {
		this.pais = pais;
	}
	public String getResultado() {
		return resultado;
	}
	public void setResultado(String resultado) {
		this.resultado = resultado;
	}
	public String getPosicao() {
		return posicao;
	}
	public void setPosicao(String posicao) {
		this.posicao = posicao;
	}
}
