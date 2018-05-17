package model;

import java.sql.Time;

public class Resultado {
	private int id_atleta;
	private int id_resultado;
	private String codigo_pais;
	private int id_Prova;
	private String nomeAtleta;
	private Time tempo;
	private int bateria;
	private String distancia;
	private String fase;
	
	public int getId_resultado() {
		return id_resultado;
	}
	public void setId_resultado(int id_resultado) {
		this.id_resultado = id_resultado;
	}
	public int getId_Prova() {
		return id_Prova;
	}
	public void setId_Prova(int id_Prova) {
		this.id_Prova = id_Prova;
	}
	public String getNomeAtleta() {
		return nomeAtleta;
	}
	public void setNomeAtleta(String nomeAtleta) {
		this.nomeAtleta = nomeAtleta;
	}
	public Time getTempo() {
		return tempo;
	}
	public void setTempo(Time tempo) {
		this.tempo = tempo;
	}
	public int getBateria() {
		return bateria;
	}
	public void setBateria(int bateria) {
		this.bateria = bateria;
	}
	public String getDistancia() {
		return distancia;
	}
	public void setDistancia(String distancia) {
		this.distancia = distancia;
	}
	public String getFase() {
		return fase;
	}
	public void setFase(String fase) {
		this.fase = fase;
	}
	public String getCodigo_pais() {
		return codigo_pais;
	}
	public void setCodigo_pais(String codigo_pais) {
		this.codigo_pais = codigo_pais;
	}
	public int getId_atleta() {
		return id_atleta;
	}
	public void setId_atleta(int id_atleta) {
		this.id_atleta = id_atleta;
	}
}
