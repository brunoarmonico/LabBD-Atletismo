package beans;

import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import controller.ControlaEvento;
import model.Resultado;

@ManagedBean
@ViewScoped
public class ResultadoBeans {
	
	private Resultado resultado = new Resultado();
	private Resultado buscaResultado = new Resultado();
	private List<Resultado> listaResultados = new ArrayList<>();
	private ControlaEvento cd = new ControlaEvento();
	
	public Resultado getResultado() {
		return resultado;
	}
	public void setResultado(Resultado resultado) {
		this.resultado = resultado;
	}
	public List<Resultado> getListaResultados() {
		return listaResultados;
	}
	public void setListaResultados(List<Resultado> listaResultados) {
		this.listaResultados = listaResultados;
	}
	public Resultado getBuscaResultado() {
		return buscaResultado;
	}
	public void setBuscaResultado(Resultado buscaResultado) {
		this.buscaResultado = buscaResultado;
	}
}
