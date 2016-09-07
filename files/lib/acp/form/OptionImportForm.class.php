<?php
namespace wcf\acp\form;
use wcf\data\option\OptionAction;
use wcf\form\AbstractForm;
use wcf\system\exception\SystemException;
use wcf\system\exception\UserInputException;
use wcf\system\WCF;
use wcf\system\WCFACP;
use wcf\util\JSON;

/**
 * Shows the option import form.
 * 
 * @author	Marcel Werk, Stefan Hahn
 * @copyright	2016 Stefan Hahn
 * @copyright	2001-2015 WoltLab GmbH
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.0xleon.wsc.optionexport
 */
class OptionImportForm extends AbstractForm {
	/**
	 * @inheritDoc
	 */
	public $activeMenuItem = 'wcf.acp.menu.link.option.importAndExport';
	
	/**
	 * @inheritDoc
	 */
	public $neededPermissions = array('admin.configuration.canEditOption');
	
	/**
	 * upload file data
	 * @var	array
	 */
	public $optionImport = null;
	
	/**
	 * list of options
	 * @var	array
	 */
	public $options = array();
	
	/**
	 * @inheritDoc
	 */
	public function readFormParameters() {
		parent::readFormParameters();
		
		if (isset($_FILES['optionImport'])) $this->optionImport = $_FILES['optionImport'];
	}
	
	/**
	 * @inheritDoc
	 */
	public function validate() {
		parent::validate();
		
		// upload
		if ($this->optionImport && $this->optionImport['error'] != 4) {
			if ($this->optionImport['error'] != 0) {
				throw new UserInputException('optionImport', 'uploadFailed');
			}
			
			try {
				$content = file_get_contents($this->optionImport['tmp_name']);
				$this->options = JSON::decode($content);
			}
			catch (SystemException $e) {
				throw new UserInputException('optionImport', 'importFailed');
			}
		}
		else {
			throw new UserInputException('optionImport');
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public function save() {
		parent::save();
		
		// save
		$this->objectAction = new OptionAction(array(), 'import', array('data' => $this->options));
		$this->objectAction->executeAction();
		$this->saved();
		
		// show success message
		WCF::getTPL()->assign('success', true);
	}
	
	/**
	 * @inheritDoc
	 */
	public function show() {
		// check master password
		WCFACP::checkMasterPassword();
		
		parent::show();
	}
}
