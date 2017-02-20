class Form extends React.Component {

  handleSubmit(e) {
    const data = {
      answer: {
        survey_id: this.props.survey.id,
        choices_attributes: this.props.choices.map((option) => ({chosen_id: option.id})),
        user_attributes: $(e.currentTarget).serializeObject()
      }
    };

    $.post('/answers.json', data)
     .done(() => { this.props.onSubmit() })
     .fail(() => { console.log(data) })

    e.preventDefault();
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit.bind(this)}>
        <label htmlFor="name">{I18n.t('name')}</label>
        <input type="text" id="name" name="name"/>
        <label htmlFor="email">{I18n.t('email')}</label>
        <input type="text" id="email" name="email"/>
        <button type="submit">{I18n.t('show_result')}</button>
      </form>
    );
  }
}

Form.propTypes = {
  choices: React.PropTypes.arrayOf(React.PropTypes.object),
  survey: React.PropTypes.object,
  onSubmit: React.PropTypes.func,
}