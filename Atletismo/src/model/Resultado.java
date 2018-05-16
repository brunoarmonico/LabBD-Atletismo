package model;

import java.sql.Time;

public class Resultado {
	
	private int id_resultado;
	private String nomeProva;
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
	public String getNomeProva() {
		return nomeProva;
	}
	public void setNomeProva(String nomeProva) {
		this.nomeProva = nomeProva;
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
}
