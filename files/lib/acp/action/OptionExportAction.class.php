<?php
namespace wcf\acp\action;
use wcf\action\AbstractAction;
use wcf\data\option\Option;
use wcf\util\JSON;

/**
 * Exports the options to an XML.
 * 
 * @author	Marcel Werk
 * @copyright	2001-2015 WoltLab GmbH
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.woltlab.wcf
 * @subpackage	acp.action
 * @category	Suite Core
 */
class OptionExportAction extends AbstractAction {
	/**
	 * @see	\wcf\action\AbstractAction::$neededPermissions
	 */
	public $neededPermissions = array('admin.configuration.canEditOption');
	
	/**
	 * @see	\wcf\action\IAction::execute();
	 */
	public function execute() {
		parent::execute();
		
		// header
		@header('Content-type: application/json');
		
		// file name
		@header('Content-disposition: attachment; filename="options.json"');
			
		// no cache headers
		@header('Pragma: no-cache');
		@header('Expires: 0');
		
		$options = Option::getOptions();
		$outputOptions = [];
		
		foreach ($options as $option) {
			if ($option->hidden) continue;
			
			$outputOptions[$option->optionName] = $option->optionValue;
		}
		
		echo JSON::encode($outputOptions);
		
		$this->executed();
		exit;
	}
}
