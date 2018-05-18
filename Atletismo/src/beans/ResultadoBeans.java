package beans;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;

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
		recebeResultados();
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

	public void enviarResultado() {
		String retorno = cd.adicionarResultado(resultado);
		if (retorno != null) {
			FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(retorno));
		}
	}

	public void recebeResultados() {
		Map<String, String> params = FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap();
		String idProva = params.get("prova");
		resultado.setId_Prova(Integer.parseInt(idProva));
		this.listaResultados = cd.listarResultados(buscaResultado);
	}
}
