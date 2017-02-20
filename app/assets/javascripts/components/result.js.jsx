class Result extends React.Component {

  constructor(props) {
    super(props);
    this.state = {globalChoices: null}
    this.loadGlobalChoices();
  }

  loadGlobalChoices(){
    const url = '/surveys/' + this.props.survey.id + '.json';
    $.get(url)
      .done((result) => {
        const globalChoices = result.options.sort((a,b) => b.score - a.score);
        this.setState({globalChoices: globalChoices})
      })
      .fail(() => console.log(data));
  }

  render() {
    return (
      <div>
        <div>{I18n.t('registration_successful')}</div>
        <div>
          <h2>{I18n.t('your_ranking')}</h2>
          {this.renderLocalChoices()}
        </div>
        <div>
          <h2>{I18n.t('general_ranking')}</h2>
          {this.renderGlobalChoices()}
        </div>
      </div>
    );
  }

  renderLocalChoices() {
    return (
      <ul>
        {this.props.choices.map((choice, key) => <li key={key}>{key + 1}. {choice.name}</li>)}
      </ul>
    );
  }

  renderGlobalChoices() {
    if (!this.state.globalChoices) {
      return <p>{I18n.t('loading')}</p>;
    } else {
      return (
        <ul>
          {this.state.globalChoices.map((choice, key) => <li key={key}>{key + 1}. {choice.name}</li>)}
        </ul>
      );
    }
  }
}

Result.propTypes = {
  choices: React.PropTypes.arrayOf(React.PropTypes.object),
  survey: React.PropTypes.object,
}