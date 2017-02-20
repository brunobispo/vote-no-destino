class Answer extends React.Component {

  constructor(props){
    super(props);
    this.state = {step: 'questions', current: 1, contestant: 0};
    this.choices = this.props.options.slice();
  }

  handleChoose(choice){
    const greater = choice == this.state.current;

    if (!greater && this.state.contestant > 0) {
      this.setState((state) => ({contestant: state.contestant - 1}));
      return;
    }

    const current = this.choices.splice(this.state.current, 1)[0];
    this.choices.splice(this.state.contestant + 1, 0, current);
  
    if (this.state.current + 1 < this.choices.length) {
      this.setState((state) => ({
        current: state.current + 1,
        contestant: state.current,
      }));
    } else {
      this.setState({step: 'form'})
    }

  }

  handleFormSubmit() {
    this.setState({step: 'result'});
  }

  render(){
    if (this.state.step == 'questions') {
      return this.renderQuestions();
    } else if (this.state.step == 'form') {
      return this.renderForm();
    } else if (this.state.step == 'result') {
      return this.renderResult();
    }
  }

  renderQuestions() {
    const option1 = this.choices[this.state.current];
    const option2 = this.choices[this.state.contestant];
    return (
      <Question key={this.state.current+this.state.contestant} id={this.state.current+this.state.contestant} onChoose={this.handleChoose.bind(this)}>
        <Option name={option1.name} imageUrl={option1.image_url} id={this.state.current}/>
        <Option name={option2.name} imageUrl={option2.image_url} id={this.state.contestant}/>
      </Question>
    );
  }

  renderForm() {
    return <Form choices={this.choices} onSubmit={this.handleFormSubmit.bind(this)} />;
  }

  renderResult(){
    return <Result/>;
  }
}

Answer.propTypes = {
  options: React.PropTypes.arrayOf(React.PropTypes.object),
}