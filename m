Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A6358D30;
	Fri,  9 Jan 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962339; cv=none; b=VVTCcAq6vjFz44TDIQD8tykh2LeviDfXgkhV7+wOx4NjY1ewgUAySnT1PyaccyQmlJoqc6HTrBmyTm6yolOSRf22iYgnmHxnnWMZkF5Xq6/xaadZ7BCJFiTmoLxVJlRWTncwMYsC14SRF44nBALiisbdoLNnP2xwGqF2Cxq/w+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962339; c=relaxed/simple;
	bh=Yt7mt2ffVM4rLsRfuUrkvL+ckVRAE0aowqK52VJ28Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0gvEgMFJLWyCoPJSaehk8YXLjleqcFMd3lfkDlrngUD8wJJ76AOAK3h/MvfMGIDrZ/vzQKamHitAzevzS1TGRn8i/kUScJFRCbjX4WmpBvtmnQdltAgzGjAbAP8aBgbrzYsLLWtqYweF1EHI8xHqfTBSV5zi4TFmORKf/sAzgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=C5FXUv3W; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="C5FXUv3W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=41i8ueWwOJhsS/IS6y3B9lBgn68ubOF0apl00N+o7dM=; b=C5FXUv3W7EKcbiWl
	+hjEToKm0hdIhUNvXU/zDTWTGT9YKe2tIryXnlgJSJj8drQgQzIVbMQwGI2mB5/XolM0vdPAXBXQI
	BhP41u2GyO/j0ojNaUJUe9L6B2zqeR+768gVF3bN9SrxuD0RRjlDif0ni2tUtHFRQqAlcQYbqhTRa
	lM8czwYeQn7nKafudf2740DWbgs+deAGdCWtgQs/i4eNMMlim/GXAgagw1rKH289OOgf5KJY5s1Eg
	pQtjAtBfhIixT+XyKRdGbNas4pfpm1cwo+Imt7fT2diP2aJMWyDT7KksGrs5vxH9f6G9T1zBzFhyF
	Yh8AgJjbHrac8h3oEw==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1veBlW-00BtVh-OY; Fri, 09 Jan 2026 12:38:54 +0000
Message-ID: <6d05b43d-82f4-46e5-be25-289143bf8353@codethink.co.uk>
Date: Fri, 9 Jan 2026 12:38:53 +0000
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit: sort missing compat prototypes
To: linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc: eparis@redhat.com, paul@paul-moore.com
References: <20260109121816.382751-1-ben.dooks@codethink.co.uk>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20260109121816.382751-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 09/01/2026 12:18, Ben Dooks wrote:
> The comapt_xxx_class symbols aren't declared in anything that
> lib/comapt_audit.c is including (arm64 build) which is causing
> the following sparse warnings:
> 
> lib/compat_audit.c:7:10: warning: symbol 'compat_dir_class' was not declared. Should it be static?
> lib/compat_audit.c:12:10: warning: symbol 'compat_read_class' was not declared. Should it be static?
> lib/compat_audit.c:17:10: warning: symbol 'compat_write_class' was not declared. Should it be static?
> lib/compat_audit.c:22:10: warning: symbol 'compat_chattr_class' was not declared. Should it be static?
> lib/compat_audit.c:27:10: warning: symbol 'compat_signal_class' was not declared. Should it be static?
> 
> Trying to fix this by chaning compat_audit.c to inclde <linux/audit.h>
> does not work on arm64 due to compile errors with the extra includes
> that changing this header makes. The simpler thing would be just to
> move the definitons of these symbols out of <linux/audit.h> into
> <linux/audit_arch.h> which is included.
> 
> Fixes: 4b58841149dca ("audit: Add generic compat syscall support")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   include/linux/audit_arch.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/audit_arch.h b/include/linux/audit_arch.h
> index 0e34d673ef17..2b8153791e6a 100644
> --- a/include/linux/audit_arch.h
> +++ b/include/linux/audit_arch.h
> @@ -23,4 +23,11 @@ enum auditsc_class_t {
>   
>   extern int audit_classify_compat_syscall(int abi, unsigned syscall);
>   
> +/* only for compat system calls */
> +extern unsigned compat_write_class[];
> +extern unsigned compat_read_class[];
> +extern unsigned compat_dir_class[];
> +extern unsigned compat_chattr_class[];
> +extern unsigned compat_signal_class[];
> +
>   #endif


Oops, forgot to commit the removal from linux/audit.h

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
