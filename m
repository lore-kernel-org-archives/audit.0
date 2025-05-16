Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D827FD6F
	for <audit@vger.kernel.org>; Fri, 16 May 2025 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747428096; cv=none; b=OYk9wN2jgAN1jQ6MCc5tjZoFer2L2nce3+0PsYQ0xDYdntg/oaQHCNlJi4ymB0JIRjULpgzrKDYE8gF6KI6gv81/AhBmoa9FkYzuiTkcxQSMjOGXZMuUlr5mYCAXhJFBsK2feiJaqkk2oGvC2FFGuQuljqQ+k9u1RKzlSlaO2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747428096; c=relaxed/simple;
	bh=XwuuFneW2BZLLz//vgZKvIX9FcOTRW2NYmS1y8zCoQU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=N2daVKPvEtflLtnkjn5X2fMNJOZhXAPyt5lyna+iC6Bl88ZOaYeKNDsMENIeS3ykiFj+bZoygoxkcjA3CAWqdq2bPnIKruO4ThStrtHtzq0y0RX6xM14I5Fsul1FmkjJVn1gWXUP2rSuXUqpzar3a4i554yg5K7NGnSLbAu4zLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y33WweJn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y33WweJn"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4947635914aso26922671cf.3
        for <audit@vger.kernel.org>; Fri, 16 May 2025 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747428094; x=1748032894; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fdr5GyRg7g4dq6gLsQfcfIbWGz/AKi8pep4CtziFBk=;
        b=Y33WweJnI75oNR9qB4dq4TnN0ntHH7MygxLQS/UlDoLNyw4GcJFXobwE9GGYfqyvl4
         h1qNPapZaUdBP2Z/JbWy6nQLXYI1ir12Rk70/r49zJ1K5hSBMREt0QxTaB8S6tQYfywH
         rulPkN+k2khYX8M05dUhFcLRMXjwgMDq+up3JB7ecRwUkPL+B108mauqswzfjH4+S29R
         qwObkFo4JqpFplMZbVhzZzBc0JnaOIFFGb4LUNgA5CrKniGrDpJ76LHZZklcpIVYCncS
         2uERw3GpFp+tbPMrfy81FQutvIS+4xEJePOk8XBixzKEQfNIsrEzIBKrEuEuz8J/nlLk
         gMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747428094; x=1748032894;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Fdr5GyRg7g4dq6gLsQfcfIbWGz/AKi8pep4CtziFBk=;
        b=dZXbrgcWwAsPqD6pUAPGZRKUaS3CnZKmJXcr0oK89GFnXWMFa0Uie4RlQsQk4+XnVI
         EGzpou4WertbV0QvJ4Mi/wZVKHkQj1yHfpp/XAgTDSi+i9O/Jk6htBqXskRN1UzAsa3x
         U/TRB0Uu2R2q2d0TaGi1Dq+00Kk6x/GaV1Ts1afFVAQRaji90BMk9eXtXOioJrS3qe6p
         rhGh7MpCXWAe73kfUboyD2A/YBjZD92/Pnb2OtPDjwgkItb9a6WbYsszckHGorgPSV2l
         y9HX3Wblme9EYsj/hFtrvO67CnGBlf88KDHtwqWgnoKRCkWTPqkvNvs0QgN6JuaY7bIu
         m0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTYu8A0THoFH0HllerN++Ji6HIEmeJ4YTo6GHIhRTxzxgUUL3FYB2IP0/6Ocb0V96Eko+MhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmimRjSQBDpIpCJQW9X7D/NbmDtqcghNju/VMMswvwcrEpbfN8
	w3Np+gjO6S09+5QdelQlXgWa5YEkq/LDvM68d5+amejxKbkJTObak5RmkSwRDyS+5w==
X-Gm-Gg: ASbGncvGopPMqs8oO96dceCeV71w+rWNF+UC3DYYU8PV0vgJ7U7kOV2XIZzy8lZ1iD2
	MLZwM4plbwCh+f1+Hok5wyYlnG5Z0al0S9hHTFRBkC4MJfwo5/EpoIsIyBLIE1xhsBRa6YjS0j/
	HAZLumTX9V/0I7UaG/8fEJPkqYtTZ53hROXtfF4d/HcefQwtB5pCcjcsv+fbVzPD8GHfjlUGHhO
	eGgInInsGGInT7ZvVEDVjcXe+LBZZUAwl1iSCsOLESw87mVZnLRDWgEyna1UX93MVGEmajgl0db
	j/1At7477USoCrOJFanllgu6DKjh77zlSGL8KvMOuahRhj4jk6UYDZrjLjZJLOthDGBZBfxfIKe
	rOxlkf+EQ1SeVRJSN+hAJ
X-Google-Smtp-Source: AGHT+IExJBXnYQy1fph2QkBpi7lveyzJWjbqIPTJ+5kqceOC9VKa/MDC8RC4s3ohkpMHez45gWI0LA==
X-Received: by 2002:ac8:714f:0:b0:494:b8bc:8adb with SMTP id d75a77b69052e-494b8bcca9emr31881741cf.5.1747428093791;
        Fri, 16 May 2025 13:41:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae425388sm15534321cf.39.2025.05.16.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:41:33 -0700 (PDT)
Date: Fri, 16 May 2025 16:41:32 -0400
Message-ID: <669e1abd542da9fbcfb466d134f01767@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250516_1624/pstg-lib:20250516_1120/pstg-pwork:20250516_1624
From: Paul Moore <paul@paul-moore.com>
To: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>, kvm@vger.kernel.org
Cc: Chathura Rajapaksha <chath@bu.edu>, William Wang <xwill@bu.edu>, Alex Williamson <alex.williamson@redhat.com>, Eric Paris <eparis@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Xin Zeng <xin.zeng@intel.com>, Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Yahui Cao <yahui.cao@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, Dongdong Zhang <zhangdongdong@eswincomputing.com>, Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] audit accesses to unassigned PCI config regions
References: <20250426212253.40473-3-chath@bu.edu>
In-Reply-To: <20250426212253.40473-3-chath@bu.edu>

On Apr 26, 2025 Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com> wrote:
> 
> Some PCIe devices trigger PCI bus errors when accesses are made to
> unassigned regions within their PCI configuration space. On certain
> platforms, this can lead to host system hangs or reboots.
> 
> The current vfio-pci driver allows guests to access unassigned regions
> in the PCI configuration space. Therefore, when such a device is passed
> through to a guest, the guest can induce a host system hang or reboot
> through crafted configuration space accesses, posing a threat to
> system availability.
> 
> This patch introduces auditing support for config space accesses to
> unassigned regions. When enabled, this logs such accesses for all
> passthrough devices. 
> This feature is controlled via a new Kconfig option:
> 
>   CONFIG_VFIO_PCI_UNASSIGNED_ACCESS_AUDIT
> 
> A new audit event type, AUDIT_VFIO, has been introduced to support
> this, allowing administrators to monitor and investigate suspicious
> behavior by guests.

I try to encourage people to put a sample audit record in the commit
description as it helps others, even those not overly familiar with the
Linux kernel, know what to expect in the audit log and provide feedback.

> Co-developed by: William Wang <xwill@bu.edu>
> 
> Signed-off-by: William Wang <xwill@bu.edu>
> Signed-off-by: Chathura Rajapaksha <chath@bu.edu>
> ---
>  drivers/vfio/pci/Kconfig           | 12 ++++++++
>  drivers/vfio/pci/vfio_pci_config.c | 46 ++++++++++++++++++++++++++++--
>  include/uapi/linux/audit.h         |  1 +
>  3 files changed, 57 insertions(+), 2 deletions(-)

...

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index cb4d11aa5598..ddd10904d60f 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -25,6 +25,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
>  #include <linux/slab.h>
> +#include <linux/audit.h>
>  
>  #include "vfio_pci_priv.h"
>  
> @@ -1980,6 +1981,37 @@ static size_t vfio_pci_cap_remaining_dword(struct vfio_pci_core_device *vdev,
>  	return i;
>  }
>  
> +enum vfio_audit {
> +	VFIO_AUDIT_READ,
> +	VFIO_AUDIT_WRITE,
> +	VFIO_AUDIT_MAX,
> +};
> +
> +static const char * const vfio_audit_str[VFIO_AUDIT_MAX] = {
> +	[VFIO_AUDIT_READ]  = "READ",
> +	[VFIO_AUDIT_WRITE] = "WRITE",
> +};

We generally don't capitalize things like this in audit, "read" and
"write" would be preferred.

> +static void vfio_audit_access(const struct pci_dev *pdev,
> +			      size_t count, loff_t *ppos, bool blocked, unsigned int op)
> +{
> +	struct audit_buffer *ab;
> +
> +	if (WARN_ON_ONCE(op >= VFIO_AUDIT_MAX))
> +		return;
> +	if (audit_enabled == AUDIT_OFF)
> +		return;
> +	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_VFIO);
> +	if (unlikely(!ab))
> +		return;
> +	audit_log_format(ab,
> +			 "device=%04x:%02x:%02x.%d access=%s offset=0x%llx size=%ld blocked=%u\n",
> +			 pci_domain_nr(pdev->bus), pdev->bus->number,
> +			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
> +			 vfio_audit_str[op], *ppos, count, blocked);
> +	audit_log_end(ab);
> +}

In the commit description you talk about a general PCIe device issue
in the first paragraph before going into the specifics of the VFIO
driver.  That's all well and good, but it makes me wonder if this
audit code above is better done as a generic PCI function that other
PCI drivers could use if they had similar concerns?  Please correct
me if I'm wrong, but other than symbol naming I don't see anyting
above which is specific to VFIO.  Thoughts?

Beyond that, I might also change the "access=" field to "op=" as we
already use the "op=" field name for similar things in audit, it would
be good to leverage that familiarity here.  Similarly using "res=",
specifically "res=0" for failure/blocked or "res=1" allowed, would
better fit with audit conventions.

> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 9a4ecc9f6dc5..c0aace7384f3 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -122,6 +122,7 @@
>  #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
>  #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
>  #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
> +#define AUDIT_VFIO		1340	/* VFIO events */

If the audit code above becomes more generalized as discussed, I would
expect this to change to AUDIT_VFIO to AUDIT_PCI, or something similar.

--
paul-moore.com
