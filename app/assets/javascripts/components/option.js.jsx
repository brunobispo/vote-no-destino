class Option extends React.Component {

  handleChange(){
    this.props.onChange(this.props.id);
  }

  render() {
    return (
      <div className="option">
        <label htmlFor={this.props.id}>          
          {this.props.imageUrl && <span className="image"><img src={this.props.imageUrl}/></span>}
          <input
            type="radio"
            name={this.props.questionId}
            value={this.props.id}
            id={this.props.id}
            onChange={this.handleChange.bind(this)}
          />
          <span className="name">{this.props.name}</span>
        </label>
      </div>
    );
  }
}

Option.propTypes = {
  id: React.PropTypes.number,
  questionId: React.PropTypes.number,
  imageUrl: React.PropTypes.string,
  name: React.PropTypes.string,
  onChange: React.PropTypes.func
}
